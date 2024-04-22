using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace NetflixDatabaseTests.Mongo
{
    

    public class Subscription
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }

        [BsonElement("userId")]
        public string UserId { get; set; } 

        [BsonElement("name")]
        public string Name { get; set; }

        [BsonElement("subscribePrice")]
        public float SubscribePrice { get; set; }
    }

}
