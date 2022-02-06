public class UpdateAcc {
    @InvocableMethod
    public static void updateTask(List < Account > accs) {
        List < Task > tasks = new List < Task > ();
        List < User > actUsers = [SELECT id, isActive FROM User WHERE isActive = true];
        for (Account acc: accs) {
            if (acc.Tasks.size() > 3) {
                Integer userIndex = Math.round(Math.random()  * actUsers.size());
                if(userIndex>=actUsers.size())
                    userIndex = actUsers.size() - 1;
                User randomUser = actUsers.get(userIndex);
                for (Task tsk: tasks) {
                    tsk.OwnerID = randomUser.id;
                    tasks.add(tsk);
                }

            }


        }
			update tasks;
    }
    

}

