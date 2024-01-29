// Controllers/ProductsController.cs

using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MyApi.Data;
using MyApi.Models;

namespace MyApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductsController : ControllerBase
    {
        private readonly AppDbContext _dbContext;

        public ProductsController(AppDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        [HttpGet]
        public IActionResult GetProducts()
        {
            var products = _dbContext.Products.ToList();
            return Ok(products);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateProduct(int id, [FromBody] Product updatedProduct)
        {
            var existingProduct = _dbContext.Products.FirstOrDefault(p => p.Id == id);

            if (existingProduct == null)
            {
                return NotFound(); // Ürün bulunamazsa 404 Not Found döndür
            }

            // Güncelleme işlemleri
            existingProduct.Name = updatedProduct.Name;
            existingProduct.Value = updatedProduct.Value;

            // Diğer özellikleri de güncelleyebilirsiniz

            _dbContext.SaveChanges();

            return Ok(existingProduct); // Güncellenmiş ürünü döndür
        }
    }
}