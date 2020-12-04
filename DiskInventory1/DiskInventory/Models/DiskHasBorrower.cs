using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;                    // Added for Project 4

namespace DiskInventory.Models
{
    public partial class DiskHasBorrower
    {
        public int Id { get; set; }                              // Added for Project 4

        [Required(ErrorMessage = "Please enter a borrower.")]    // Added for Project 4
        public int BorrowerId { get; set; }
        public virtual Borrower Borrower { get; set; }          // Moved from bottom

        [Required(ErrorMessage = "Please enter a disk.")]       // Added for Project 4
        public int DiskId { get; set; }
        public virtual Disk Disk { get; set; }                  // Moved from bottom

        [Required(ErrorMessage = "Please enter a borrowed date.")]  //Added for Project 4
        public DateTime BorrowedDate { get; set; }
        public DateTime? ReturnedDate { get; set; }



    }
}
