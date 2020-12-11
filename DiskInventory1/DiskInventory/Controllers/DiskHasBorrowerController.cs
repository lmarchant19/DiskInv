using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using DiskInventory.Models;
using Microsoft.EntityFrameworkCore;

namespace DiskInventory.Controllers
{
    public class DiskHasBorrowerController : Controller
    {
        private disk_inventorylmContext context { get; set; }                    // Student context name will differ
        public DiskHasBorrowerController(disk_inventorylmContext ctx)            // Student context name will differ
        {
            context = ctx;
        }
        public IActionResult List()
        {
            //List<DiskHasBorrower> diskhasborrowers = context.DiskHasBorrower.OrderBy(db => db.DiskId).ThenBy(db => db.BorrowerId).ToList();
            var diskhasborrowers = context.DiskHasBorrower.OrderBy(db => db.BorrowedDate).
                Include(d => d.Disk).OrderBy(d => d.DiskId).
                Include(b => b.Borrower).OrderBy(b => b.BorrowerId).ToList();
            return View(diskhasborrowers);
        }

        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            ViewBag.Disks = context.Disk.OrderBy(d => d.DiskName).ToList();
            ViewBag.Borrowers = context.Borrower.OrderBy(b => b.Lname).ToList();
            return View("Edit", new DiskHasBorrower());
        }
        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            ViewBag.Disks = context.Disk.OrderBy(d => d.DiskName).ToList();
            ViewBag.Borrowers = context.Borrower.OrderBy(b => b.Lname).ToList();
            var diskhasborrower = context.DiskHasBorrower.Find(id);
            return View(diskhasborrower);
        }

        [HttpPost]
        public IActionResult Edit(DiskHasBorrower diskhasborrower)
        {
            if (ModelState.IsValid)
            {
                if (diskhasborrower.Id == 0)
                    context.DiskHasBorrower.Add(diskhasborrower);
                else
                    context.DiskHasBorrower.Update(diskhasborrower);
                context.SaveChanges();
                return RedirectToAction("List", "DiskHasBorrower");
            }
            else
            {
                ViewBag.Action = (diskhasborrower.Id == 0) ? "Add" : "Edit";
                ViewBag.Disks = context.Disk.OrderBy(d => d.DiskName).ToList();
                ViewBag.Borrowers = context.Borrower.OrderBy(b => b.Lname).ToList();
                return View(diskhasborrower);
            }
        }
    }
}
