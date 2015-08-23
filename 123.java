		/*
		package action;

		import java.util.ArrayList;
		import java.util.List;

		import org.apache.struts2.ServletActionContext;

		import com.opensymphony.xwork2.ActionSupport;
		import com.opensymphony.xwork2.ModelDriven;

		import databean.searchDataDatabean;
		import databean.searchDatabean;
		import databean.searchSelectKeyDatabean;


		public class doSearch extends ActionSupport implements
				ModelDriven<searchDatabean> {


			private static final long serialVersionUID = 1L;

			private searchDatabean selectKey = new searchDatabean();

			public searchDatabean getSelectKey() {
				return selectKey;
			}

			public void setSelectKey(searchDatabean selectKey) {
				this.selectKey = selectKey;
			}

			public String doSelect() {
				System.out.println("start action.doSelect");
				List<searchDataDatabean> modelList = new ArrayList<searchDataDatabean>();
				for (int i = 0; i < 10; i++) {
					searchDataDatabean model = new searchDataDatabean();
					model.setMembercode("S131293" + i);
					model.setName("员工名" + i);
					model.setJob_level("实习" + i);
					model.setAnnual_income("1,200.00");
					model.setDeptcode("1111" + i);
					model.setDeptnm("实习部");
					modelList.add(model);
				}
				ServletActionContext.getRequest().setAttribute("modelList", modelList);

				ServletActionContext.getRequest().setAttribute("nameInput",
						this.selectKey.getNameInput());
				ServletActionContext.getRequest().setAttribute("membercodeInput",
						this.selectKey.getMembercodeInput());
				return "success";
			}

			@Override
			public searchDatabean getModel() {
				return selectKey;
			}
		}
*/
