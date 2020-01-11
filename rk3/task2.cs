using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;

namespace RK3
{
    class Program
    {
        static readonly string connectionString = @"server = localhost;Initial Catalog = tempdb;integrated security = true;";
        static SqlConnection connection = null;
        static int id = 0;
        
        static void Main(string[] args)
        {
            connection = new SqlConnection(connectionString);
            connection.Open();
            string answer = String.Empty;

            do
            {
                Console.WriteLine("MENU");
                Console.WriteLine("1. Show people");
                Console.WriteLine("q. Exit");
                Console.Write("->");
                answer = Console.ReadLine();

                switch (answer)
                {
                    case "1":
                        {
                            ShowFilials();
                            break;
                        }
                    case "q":
                        {
                            break;
                        }

                    default:
                        {
                            Console.WriteLine("Not correct choice!");
                            break;
                        }
                }

                Console.WriteLine();
            }
            while (answer != "q");

            connection.Close();
        }

        static void ShowFilials()
        {
            Console.WriteLine("Table:");

            try
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = "select orgName, personName from person as a join org as b on a.orgID = b.orgID where phoneNum like('%7%'), connection ";

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            Console.Write(reader[i].ToString());
                            Console.Write('\t');
                        }

                        Console.WriteLine();
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }            
        }
    }
}
