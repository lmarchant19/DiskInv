using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DiskInventory.Models
{
    public partial class Disk
    {
        public Disk()
        {
            DiskHasArtist = new HashSet<DiskHasArtist>();
            DiskHasBorrower = new HashSet<DiskHasBorrower>();
        }

        public int DiskId { get; set; }

        [Required]
        public string DiskName { get; set; }

        [Required(ErrorMessage = "Please enter a release date.")]
        public DateTime ReleaseDate { get; set; }

        [Required(ErrorMessage = "Please select a genre.")]
        public int GenreId { get; set; }

        [Required(ErrorMessage = "Please select a status.")]
        public int StatusId { get; set; }

        [Required(ErrorMessage = "Please select a disk type.")]
        public int DiskTypeId { get; set; }

        public virtual DiskType DiskType { get; set; }
        public virtual Genre Genre { get; set; }
        public virtual Status Status { get; set; }
        public virtual ICollection<DiskHasArtist> DiskHasArtist { get; set; }
        public virtual ICollection<DiskHasBorrower> DiskHasBorrower { get; set; }
    }
}
