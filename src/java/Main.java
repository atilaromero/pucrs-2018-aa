

import jason.JasonException;
import jason.infra.centralised.RunCentralisedMAS;
import massim.Server;

public class Main {

	public static void main(String[] args) {
		new Thread(new Runnable() {
			public void run() {
				try {
					Server.main(new String[] {"-conf", "conf/SampleConfig.json", "--monitor"});
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}).start();


		try {			
			RunCentralisedMAS.main(new String[] {"multiagentContest2017.mas2j"});
		} catch (JasonException e) {
			System.out.println("Exception: "+e.getMessage());
			e.printStackTrace();
		}
	}

}
