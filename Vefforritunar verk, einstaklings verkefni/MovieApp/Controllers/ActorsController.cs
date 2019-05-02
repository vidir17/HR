using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using MovieApp.Models.InputModels;
using MovieApp.Models.ViewModels;
using MovieApp.Models.EntityModels;
using MovieApp.Models;

namespace MovieApp.Controllers
{
    public class ActorsController : Controller
    {
        public IActionResult Index()
        {
            ViewData["Actors"] = "Actors";
            var TheActorList = (from s in FakeDatabase.Actors 
                          select new ActorViewModel
                          {
                              Id = s.Id,
                              Name = s.Name,
                              Age = s.Age,
                          }).ToList();
            return View(TheActorList);
        }
        

        public IActionResult Details(int Id)
        {
            
             var Actorss = (from s in FakeDatabase.Actors where Id == s.Id
             select new ActorViewModel{
                Id = s.Id,
                Name = s.Name,
                Age = s.Age,
             }).SingleOrDefault();
            
            return View(Actorss);
        }
        

        public IActionResult Error()
        {
            return View(new ErrorViewModel {RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier});
        }

   
    }
}