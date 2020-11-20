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
            List<Disk> disks = context.Disk.OrderBy(a => a.DiskName).ToList();
            return View(disks);
        }
        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            ViewBag.DiskTypes = context.DiskType.OrderBy(t => t.Description).ToList();
            return View("Edit", new Disk());
        }

        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            ViewBag.DiskTypes = context.DiskType.OrderBy(t => t.Description).ToList();
            var disk = context.Disk.Find(id);
            return View(disk);
        }

        [HttpPost]

        public IActionResult Edit(Disk disk)
        {
            if (ModelState.IsValid)
            {
                if (disk.DiskId == 0)
                    context.Disk.Add(disk);
                else
                    context.Disk.Update(disk);
                context.SaveChanges();
                return RedirectToAction("List", "Disk");
            }
            else
            {
                ViewBag.Action = (disk.DiskId == 0) ? "Add" : "Edit";
                ViewBag.DiskTypes = context.DiskType.OrderBy(t => t.Description).ToList();
                return View(disk);
            }
        }

        [HttpGet]

        public IActionResult Delete(int id)
        {
            var disk = context.Disk.Find(id);
            return View(disk);
        }

        [HttpPost]

        public IActionResult Delete(Disk disk)
        {
            context.Disk.Remove(disk);
            context.SaveChanges();
            return RedirectToAction("List", "Disk");
        }
    }
}
