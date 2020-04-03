function openNextWeek(param){
       $.trace.debug('entered function forecast lib openNextWeek');
       let after = param.afterTableName; // temporary table
       // create a new week with previous forecast month and forecast year
       $.trace.debug();
       let pStmt = param.connection.prepareStatement('update "' + after + '" set CID = "ServiceNS.services.sd.presupuesto.data::CID".NEXTVAL' );
       pStmt.executeUpdate();
       pStmt.close();
}