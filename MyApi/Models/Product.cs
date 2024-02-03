using System;
using System.ComponentModel.DataAnnotations;
namespace MyApi.Models
{
    public class Product
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Id is required")]

        public string? Name { get; set; } 
        [Required(ErrorMessage = "Name is required")]

        public int Value { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime ModifiedAt { get; set; }
        public DateTime? DeletedAt { get; set; }
    }
}
