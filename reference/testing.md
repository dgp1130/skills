# Testing

When generating tests, follow this general philosophy.

## Correct by Inspection

Tests should be "correct by inspection", meaning that they should be so obviously correct that there
can't possibly be a bug. This means tests should generally not have conditionals, loops, or other
control flow structures. If such checks are necessary, they should be placed in test utilities, and
potentially include their own tests to validate their behavior.

## Locality

The data necessary to validate a given test should be defined within that test. Don't rely on global
setup for state critical to a test.

```typescript
// BAD! Relies on external setup for important state.
const user = new User('Devel');
it('should have the correct name', () => {
  expect(user.name).toBe('Devel');
});

// GOOD! All data is defined within the test.
it('should have the correct name', () => {
  const user = new User('Devel');
  expect(user.name).toBe('Devel');
});

// OK! External setup for non-critical state is acceptable.
const user = new User('Devel');
it('should have the correct name', () => {
  // Don't actually care about `user` here, just needs to exist to create a `Company`.
  const company = new Company('dwac.dev', /* admin */ user);
  expect(company.domain).toBe('dwac.dev');
});
```

## Explicit Absence

Be explicit in a comment when a value *not* being provided is intentional and meaningful to the
test.

```typescript
// BAD! It's not clear why `domain` is `undefined`.
it('should not have an domain when none is provided', () => {
  const company = new Company();
  expect(company.domain).toBeUndefined();
});

// GOOD! It's important that no `domain` is set.
it('should not have an domain when none is provided', () => {
  const company = new Company(
    /* domain */ undefined,
  );
  expect(company.domain).toBeUndefined();
});
```
