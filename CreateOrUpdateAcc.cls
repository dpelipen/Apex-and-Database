public class CreateOrUpadateAcc {

    @InvocableMethod
    public static void createTask(List < Account > accs) {
        List < Task > taskList = new List < Task > ();
        for (Account acc: accs) {

            Task tsk = new Task();
            tsk.Subject = 'Negotiations with ' + acc.Name;
            tsk.WhatId = acc.ID;
            tsk.OwnerId = acc.OwnerId;
            taskList.add(tsk);

        }

        insert taskList;
    }
}
