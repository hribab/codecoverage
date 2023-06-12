global class BatchScheduleUpdate implements Schedulable {
    
    
    global void execute(SchedulableContext sc)
    {
        batchSpecializationaccountinsert b = new batchSpecializationaccountinsert ();      
        
        database.executebatch(b,10);
    }

}