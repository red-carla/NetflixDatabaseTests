using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetflixDatabaseTests
{
    public class ADOdBAccess
    {
        private string connectionString = "Server=localhost;Database=netflixDB;Trusted_Connection=True;TrustServerCertificate=True;";

        public SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }

        public void InsertMultipleUsers(int numberOfUsers)
        {
            using (var connection = GetConnection())
            {
                connection.Open();
                for (int i = 0; i < numberOfUsers; i++)
                {
                    var command = new SqlCommand("INSERT INTO [User] (Username, Email) VALUES (@Username, @Email)", connection);
                    command.Parameters.AddWithValue("@Username", $"testUser{i}");
                    command.Parameters.AddWithValue("@Email", $"user{i}@example.com");

                    command.ExecuteNonQuery();
                }
            }
        }
        public void GetMultipleUsers(int numberOfUsers)
        {
            using (var connection = GetConnection())
            {
                connection.Open();
                for (int i = 0; i < numberOfUsers; i++)
                {
                    var command = new SqlCommand("SELECT UserId, Username, Email FROM [User] WHERE UserID = @UserID", connection);
                    command.Parameters.AddWithValue("@UserID", i);

                    {
                        var reader = command.ExecuteReader();
                        while (reader.Read())
                        {
                            Console.WriteLine($"ADO Username: {reader["Username"]}, Email: {reader["Email"]}");

                        }
                        reader.Close();
                    }
                }
            }
        }
        public void UpdateMultipleUsers(int numberOfUsers)
        {
            using (var connection = GetConnection())
            {
                connection.Open();
                for (int i = 0; i < numberOfUsers; i++)
                {
                    var command = new SqlCommand("UPDATE [User] SET Email = @Email WHERE UserID = @UserID", connection);

                    command.Parameters.AddWithValue("@Email", $"changed{i}@example.com");
                    command.Parameters.AddWithValue("@UserID", i);
                    command.ExecuteNonQuery();
                }
            }
        }

        public void DeleteMultipleUsers(int numberOfUsers)
        {
            using (var connection = GetConnection())
            {
                connection.Open();
                for (int i = 0; i < numberOfUsers; i++)
                {
                    var command = new SqlCommand("DELETE FROM [User] WHERE UserID = @UserID", connection);
                    command.Parameters.AddWithValue("@UserID", i);
                    command.ExecuteNonQuery();
                }
            }
        }

    }
}