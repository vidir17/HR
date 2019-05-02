using System.ComponentModel.DataAnnotations;

namespace MovieApp.Models.InputModels
{
    public class MovieCreateModel{
        [Required(ErrorMessage = "Insert Title!")]
        public string Title {get; set;}
        [Required(ErrorMessage = "Insert Genre!")]
        public string Genre {get; set;}
        [Required(ErrorMessage = "Insert ReleaseYear!")]
        public int ReleaseYear {get; set;}
        [Required(ErrorMessage = "Insert Runtime!")]
        public int Runtime {get; set;}
    }
}