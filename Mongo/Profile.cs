using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace NetflixDatabaseTests.Mongo
{
    public class Profile
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }

        [BsonElement("userId")]
        public string UserId { get; set; }  // Assuming a reference to User collection if needed

        [BsonElement("profileName")]
        public string ProfileName { get; set; }

        [BsonElement("dateOfBirth")]
        public DateTime DateOfBirth { get; set; }

        [BsonElement("avatar")]
        public string Avatar { get; set; }
    }
}
