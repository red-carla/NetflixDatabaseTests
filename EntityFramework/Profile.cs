using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetflixDatabaseTests.EntityFramework
{
    public class Profile
    {
        public int ProfileId { get; set; }
        public int UserId { get; set; }
        public string ProfileName { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string Avatar { get; set; }
        public User User { get; set; }
    }
}
