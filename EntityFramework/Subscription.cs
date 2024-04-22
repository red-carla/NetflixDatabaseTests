using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetflixDatabaseTests.EntityFramework
{
    public class Subscription
    {
        public int SubscriptionId { get; set; }
        public int UserId { get; set; }
        public string Name { get; set; }
        public float SubscribePrice { get; set; }
        public User User { get; set; }
    }
}
