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
    public class MoviesController : Controller
    {
        public IActionResult Index(string SearchString)
        {
            ViewData["Movies"] = "Movies";
            var TheMovieList = (from s in FakeDatabase.Movies
                          select new MovieViewModel
                          {
                              Id = s.Id,
                              Title = s.Title,
                              Genre = s.Genre,
                              Image = s.Image,
                              Rating = s.Rating,
                              ReleaseYear = s.ReleaseYear,
                              Runtime = s.Runtime,
                          }).ToList();
            
            if(!String.IsNullOrEmpty(SearchString))
            {
                var Leitarstrengur = (from s in TheMovieList.Where(
               s => s.Title.ToLower().Contains(SearchString.ToLower())) select s).ToList();
                return View(Leitarstrengur);
            }

            return View(TheMovieList);
        }

        public IActionResult TopFive()
        {
            var TheMovieList = (from s in FakeDatabase.Movies
                          orderby s.Rating descending
                          select new MovieViewModel
                          {
                              Id = s.Id,
                              Title = s.Title,
                              Genre = s.Genre,
                              Image = s.Image,
                              Rating = s.Rating,
                              ReleaseYear = s.ReleaseYear,
                              Runtime = s.Runtime,
                          }).Take(5).ToList();
                          return View(TheMovieList);
        }

        public IActionResult Details(int Id)
        {
            ViewData["Movies"] = "Movies";
             var breyta = (from s in FakeDatabase.Movies where Id == s.Id
             select new MovieViewModel{
                Id = s.Id,
                Title = s.Title,
                Genre = s.Genre,
                Image = s.Image,
                Rating = s.Rating,
                ReleaseYear = s.ReleaseYear,
                Runtime = s.Runtime,
             }).SingleOrDefault();
            
            return View(breyta);
        }
        [HttpGet]
        public IActionResult Create()
        {
            ViewData["Movies"] = "Movies";

            return View();
        }
        [HttpPost]
        public IActionResult Create(MovieCreateModel newMovie)
        {
            /*ViewData["Movies"] = "Movies";*/
            if(ModelState.IsValid)
            {   
                FakeDatabase.Movies.Add( new Movie{
                    Id = FakeDatabase.Movies.Count +1,
                    Title = newMovie.Title,
                    Genre = newMovie.Genre,
                    ReleaseYear = newMovie.ReleaseYear,
                    Runtime = newMovie.Runtime,
                    Image = "",
                    Rating = 0,

                });
                return RedirectToAction("Index");
            }
            return View();
        }

        public IActionResult Error()
        {
            return View(new ErrorViewModel {RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier});
        }

/*
        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }
 */
   
    }
}