using Microsoft.EntityFrameworkCore;
using NetflixDatabaseTests.Mongo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetflixDatabaseTests.EntityFramework
{
    public class EfContext : DbContext

    {

        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<Profile> Profiles { get; set; }
        public virtual DbSet<Subscription> Subscriptions { get; set; }



        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Server=localhost;Database=netflixDB;Trusted_Connection=True;TrustServerCertificate=True;");
        }
    
        public void InsertMultipleUsers(int numberOfUsers)
        {
            using (var context = new EfContext())
            {
                for (int i = 0; i < numberOfUsers; i++)
                {
                    var user = new User { Username = $"testUser{i}", Email = $"user{i}@example.com" };
                    context.Users.Add(user);

                }
                context.SaveChanges();
            }
        }

        public void GetMultipleUsers(int numberOfUsers)
        {
            using (var context = new EfContext())
            {
                for (int i = 0; i < numberOfUsers; i++)
                {
                    var user = context.Users.Find(i);
                    if (user != null)
                    {
                        Console.WriteLine($"EF Username: {user.Username}, Email: {user.Email}");
                    }
                }
            }
        }
        public void UpdateMultipleUsers(int numberOfUsers)
        {
            using (var context = new EfContext())
            {
                for (int i = 0; i < numberOfUsers; i++)
                {
                    var user = context.Users.Find(i);
                    if (user != null)
                    {
                        user.Email = $"changed{i}@example.com";
                    }
                }
                context.SaveChanges();
            }
        }
        public void DeleteMultipleUsers(int numberOfUsers)
        {
            var usersToDelete = Users.Take(numberOfUsers).ToList();

            foreach (var user in usersToDelete)
            {
                Users.Remove(user);
            }

            SaveChanges();
        }
    }

}