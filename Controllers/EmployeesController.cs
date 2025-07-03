using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[ApiController]
[Route("api/[controller]")]
public class EmployeesController : ControllerBase
{
    private readonly AppDbContext _context;

    public EmployeesController(AppDbContext context)
    {
        _context = context;
    }

    /// <summary>
    /// Create new employee
    /// </summary>
    /// <param name="employee">Object of class Employee</param>
    /// <returns>Created employee</returns>
    [HttpPost]
    public async Task<ActionResult<Employee>> CreateEmployee(Employee employee)
    {
        _context.Employee.Add(employee);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetEmployee), new { id = employee.EmployeeId }, employee);
    }

    /// <summary>
    /// Delete employee by ID
    /// </summary>
    /// <param name="id">Employee ID</param>
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteEmployee(int id)
    {
        var employee = await _context.Employee.FindAsync(id);
        if (employee == null)
            return NotFound();

        _context.Employee.Remove(employee);
        await _context.SaveChangesAsync();

        return NoContent();
    }

    /// <summary>
    /// Get employee by ID
    /// </summary>
    /// <param name="id">Employee ID</param>
    /// <returns>Information about employee</returns>
    [HttpGet("{id}")]
    public async Task<ActionResult<Employee>> GetEmployee(int id)
    {
        var employee = await _context.Employee.FindAsync(id);
        if (employee == null) return NotFound();
        return employee;
    }

    /// <summary>
    /// Get all employees
    /// </summary>
    /// <returns>List of all employees</returns>
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Employee>>> GetEmployees()
    {
        return await _context.Employee.ToListAsync();
    }

    /// <summary>
    /// Get employees by position ID
    /// </summary>
    /// <param name="positionId">Position ID</param>
    /// <returns>List of employees</returns>
    [HttpGet("position/{positionId}")]
    public async Task<ActionResult<List<Employee>>> GetEmployeesByPosition(int positionId)
    {
        var employees = await _context.Employee
            .Where(e => e.PositionId == positionId)
            .ToListAsync();

        if (employees == null || employees.Count == 0)
            return NotFound();

        return employees;
    }

    /// <summary>
    /// Update information about employee
    /// </summary>
    /// <param name="id">Employee ID</param>
    /// <param name="employee">Information about employee</param>
    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateEmployee(int id, Employee employee)
    {
        if (id != employee.EmployeeId)
            return BadRequest();

        _context.Entry(employee).State = EntityState.Modified;

        try
        {
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!EmployeeExists(id))
                return NotFound();
            else
                throw;
        }

        return NoContent();
    }

    private bool EmployeeExists(int id)
    {
        return _context.Employee.Any(e => e.EmployeeId == id);
    }
}