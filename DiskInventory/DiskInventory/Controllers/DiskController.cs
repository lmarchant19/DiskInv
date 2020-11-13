using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using DiskInventory.Models;

namespace DiskInventory.Controllers
{
    public class DiskController : Controller
    {
        private disk_inventorylmContext context { get; set; }     //Student context name will differ
        public DiskController(disk_inventorylmContext ctx)    //Student context name will differ
        {
            context = ctx;
        }
        public IActionResult List()
        {
            List<Borrower> borrowers = context.Borrower.OrderBy(a => a.Lname).ToList();
            return View(borrowers);
        }
    }
}
