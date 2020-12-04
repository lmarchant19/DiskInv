using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace DiskInventory.Models
{
    public partial class Artist
    {
        public Artist()
        {
            DiskHasArtist = new HashSet<DiskHasArtist>();
        }

        public int ArtistId { get; set; }

        [Required(ErrorMessage = "Please enter a First Name.")]
        public string Fname { get; set; }

        public string Lname { get; set; }

        [Required(ErrorMessage = "Please select an artist type.")]
        public int ArtistTypeId { get; set; }

        public virtual ArtistType ArtistType { get; set; }
        public virtual ICollection<DiskHasArtist> DiskHasArtist { get; set; }
    }
}
