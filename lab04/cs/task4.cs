using System;  
using System.Data.SqlTypes;  
using System.Data.SqlClient;  
using Microsoft.SqlServer.Server;   
  
public class StoredProcedures   
{  
   [Microsoft.SqlServer.Server.SqlProcedure]  
   public static void RamSum(out SqlInt32 value)  
   {  
      using(SqlConnection connection = new SqlConnection("context connection=true"))   
      {  
         value = 0;  
         connection.Open();  
         SqlCommand command = new SqlCommand("SELECT idSt FROM exch where cost < 1000", connection);  
         SqlDataReader reader = command.ExecuteReader();  
  
         using (reader)  
         {  
            reader.Read();
			value = reader.GetSqlInt32(0); 
         }           
      }  
   }  
}  