using System;
using System.Collections.Generic;

namespace DiskInventory.Models
{
    public partial class Borrower
    {
        public Borrower()
        {
            DiskHasBorrower = new HashSet<DiskHasBorrower>();
        }

        public int BorrowerId { get; set; }
        public string Fname { get; set; }
        public string Lname { get; set; }
        public string PhoneNum { get; set; }

        public virtual ICollection<DiskHasBorrower> DiskHasBorrower { get; set; }
    }
}
