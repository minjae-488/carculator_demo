# Project Rules

This document defines the coding standards and development practices for the Carculator project.

## 1. Test-Driven Development (TDD)
**Scope**: Core Logic Only (Strictly Excluding UI)

All core business logic must be implemented using TDD. Follow the **Red-Green-Refactor** cycle:

1.  **Red**: Write a failing test case that describes the desired behavior of a specific unit (function or class).
2.  **Green**: Write the minimum amount of code necessary to make the test pass.
3.  **Refactor**: Improve the code structure and quality (adhering to SOLID principles) while ensuring all tests still pass.

**Strict Rule**:
- **NO Automated UI Tests**: Do not write any tests that render components, interact with the DOM, or check styles. Focus solely on pure JavaScript/TypeScript logic.
- UI validation should be done manually.

**Exemptions**:
- Pure UI components (rendering logic, DOM manipulation).
- Configuration files.

**Tools**:
- Use Vitest for unit testing.

## 2. SOLID Principles
All code implementation must adhere to the SOLID principles to ensure maintainability and scalability.

### S - Single Responsibility Principle (SRP)
- Each class, module, or function should have one, and only one, reason to change.
- **Example**: Separate the Calculator logic (state management) from the MathOperations (pure calculations) and Display (DOM updates).

### O - Open/Closed Principle (OCP)
- Software entities should be open for extension, but closed for modification.
- **Example**: New calculator operations (e.g., trigonometric functions) should be added by creating new command objects or functions.

### L - Liskov Substitution Principle (LSP)
- Subtypes must be substitutable for their base types.

### I - Interface Segregation Principle (ISP)
- Clients should not be forced to depend on methods they do not use.

### D - Dependency Inversion Principle (DIP)
- High-level modules should not depend on low-level modules. Both should depend on abstractions.
