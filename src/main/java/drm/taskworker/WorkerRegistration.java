/*
    Copyright 2013 KU Leuven Research and Development - iMinds - Distrinet

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

    Administrative Contact: dnet-project-office@cs.kuleuven.be
    Technical Contact: bart.vanbrabant@cs.kuleuven.be
 */

package drm.taskworker;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import drm.taskworker.config.Config;

/**
 * This class starts pull workers for processing tasks from pull queues
 * 
 * @author Bart Vanbrabant <bart.vanbrabant@cs.kuleuven.be>
 */
public class WorkerRegistration implements ServletContextListener {
	private List<Worker> background_threads = null;

	public WorkerRegistration() {
		background_threads = new ArrayList<Worker>();
	}

	private void addWorker(Worker worker) {
		Thread thread = new Thread(worker);
		thread.setDaemon(true);
		this.background_threads.add(worker);
		thread.start();
	}

	public void contextInitialized(ServletContextEvent event) {
		// first ensure that the keyspace exists
		Entities.cs();
		
		// now start the workflow engine
		InputStream input = event.getServletContext().getResourceAsStream("/WEB-INF/workers.yaml");
		Config config = Config.loadConfig(input);

		if (config.getScheduler() != null) {
			//scheduler means master server
			
			config.getScheduler().create();

			// start a thread to manage the queue service
			Thread thread = new Thread(new Runnable() {
						@Override
						public void run() {
							while (true) {
								Service.get().startJobs();
								try {
									Thread.sleep(2000);
								} catch (InterruptedException e) {
									e.printStackTrace();
								}
							}
						}
					});
			
			thread.setDaemon(true);
			thread.start();
		}

		for (drm.taskworker.config.WorkerConfig worker : config.getWorkers().values()) {
			Worker w = worker.getWorkerInstance();
			this.addWorker(w);
		}

	}

	/**
	 * Stop all worker threads when the servlet is destroyed.
	 */
	public void contextDestroyed(ServletContextEvent event) {
		for (Worker thread : this.background_threads) {
			thread.stopWorking();
		}
	}
}
