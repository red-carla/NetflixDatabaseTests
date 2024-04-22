using MongoDB.Bson;
using MongoDB.Driver;
using MongoDB.Driver.Core.Configuration;
using NetflixDatabaseTests.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetflixDatabaseTests.Mongo
{
    public class MongoDBAccess


    {
        public async Task InsertMultipleUsers(int numberOfUsers)
        {
            MongoClient client = new MongoClient("mongodb://localhost:27017");
            var userCollection = client.GetDatabase("NetflixDB").GetCollection<BsonDocument>("Users");
            var users = GenerateUsers(numberOfUsers);
            await userCollection.InsertManyAsync(users);
        }

        private IEnumerable<BsonDocument> GenerateUsers(int numberOfUsers)
        {
            var users = new List<BsonDocument>();
            for (int i = 0; i < numberOfUsers; i++)
            {
                var user = new BsonDocument
                {
                    { "username", $"testUser{i}" },
                    { "email", $"user{i}@example.com"},
                };
                users.Add(user);
            }
            return users;
        }
        public async Task<IEnumerable<BsonDocument>> GetMultipleUsers(int numberOfUsers)
        {
            MongoClient client = new MongoClient("mongodb://localhost:27017");
            var userCollection = client.GetDatabase("NetflixDB").GetCollection<BsonDocument>("Users");
            var filter = Builders<BsonDocument>.Filter.Empty;
            var cursor = await userCollection.Find(filter).Limit(numberOfUsers).ToCursorAsync();
            return await cursor.ToListAsync();
        }

        public async Task UpdateMultipleUsers(int numberOfUsers)
        {
            MongoClient client = new MongoClient("mongodb://localhost:27017");
            var userCollection = client.GetDatabase("NetflixDB").GetCollection<BsonDocument>("Users");
            for (int i = 0; i < numberOfUsers; i++)
            {
                var filter = Builders<BsonDocument>.Filter.Empty;
                var update = Builders<BsonDocument>.Update.Set("email", $"changed{i}@newOne.com");
                var updateOptions = new UpdateOptions { IsUpsert = false };
                await userCollection.UpdateOneAsync(filter, update, updateOptions);
            }
        }
        public async Task DeleteMultipleUsers(int numberOfUsers)
        {
            MongoClient client = new MongoClient("mongodb://localhost:27017");
            var userCollection = client.GetDatabase("NetflixDB").GetCollection<BsonDocument>("Users");
            var filter = Builders<BsonDocument>.Filter.Empty;
            await userCollection.DeleteOneAsync(filter);

        }

    }
}
