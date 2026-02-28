# TypeScript / JavaScript Style Guide

When generating code, follow the below guidance on my personal "voice" of TS / JS code. Prefer
following project-local and file-local conventions where they appear to disagree with this guidance.

## Avoid `any` Whenever Possible

Do *not* use `any` as a type unless absolutely necessary. If writing a function where the type is
genuinely not known, prefer `unknown` over `any`.

## Type Inference

Prefer type inference over explicit type annotations when reasonable.

```typescript
// BAD! Unnecessary type annotation.
const x: number = getId();

// GOOD! Type is inferred.
const x = getId();
```

Do use explicit type annotations when necessary or when the type is not obvious.

```typescript
// GOOD! Type is not otherwise obvious.
const x: number = doComplicatedThing(withSomeArgumentWhichDefinesTheReturnType());
```

## Prefer `undefined` over `null`

Prefer `undefined` as the "no value" literal over `null`, as this aligns better with options
parameter and properties.

## Name Empty Arguments

When calling a function with `null`, `undefined`, generic primitive value, or other "empty" value,
name the argument with a preceding comment.

```typescript
function foo(id: number, company: Company | null, org: Org | undefined, label: string, user: User, name: string): void;

// BAD! Unclear what argument means what.
foo(1, null, undefined, 'test', user, getName());

// GOOD! Clear what each argument is.
foo(
  /* id */ 1,
  /* company */ null,
  /* org */ undefined,
  /* label */ 'test',
  user, // No need to name arguments with clear meaning.
  getName(), // No need to name arguments with clear meaning.
);
```

## Single-Line Control Flow

Control flow states may omit braces if the body is short, simple, and fits on one line.

```typescript
// BAD! More involved than necessary.
if (x) {
  return y();
}

// BAD! Too long.
if (someLongConditional) return doSomethingEvenLongerAndMoreComplex(withComplicatedArgument());

// GOOD! Simple and clear.
if (x) return y();
for (const x of y) validate(x);
if (!isValid(x)) throw new Error('...');
if (!isValid(x)) continue;
```

## Iterators

Prefer `for` loops over `while` loops whenever possible. Avoid manual iteration in a `for` loop and
`for...in` whenever possible. Consider the use of generators for more complex iteration patterns.
Use `Generator<T, void, void>` as the preferred return type.

```typescript
// BAD! Iteration and function body are tied together.
let i = 0;
while (i < 10) {
  // ...
  i++;
}

// BAD! Can do better.
for (let i = 0; i < 10; i++) {
  // ...
}

// GOOD!
for (const x of y) {
  // ...
}

// GOOD! Generator can manage complex iteration patterns.
function* generate(x: number): Generator<number, void, void> {
  let i = 0;
  while (i < x) {
    yield i;
    i++;
  }
}
for (const x of generate(10)) {
  // ...
}
```

## Immutability

Prefer `readonly` and `const` whenever possible. Avoid mutable data structures unless necessary.

Consider using `Object.freeze()` for deeply-immutable objects which are widely referenced outside
a single abstraction. This isn't necessary for most objects, but can be useful for things like a
global shared configuration.

## Minimize Constructors

Avoid doing any meaningful work in a constructor. Constructors exist to save input state to class
fields and call `super`, nothing more. If a class requires significant setup, consider using a
factory function.

```typescript
// BAD! Doing side effects in a constructor.
class User {
  constructor(name: string) {
    this.name = name;
    this.company = getCompany(name);
  }
}

// GOOD! Only saving state to fields, other work is moved to a factory.
class User {
  private constructor(name: string, company: Company) {
    this.name = name;
    this.company = company;
  }

  static of(name: string): User {
    return new User(name, getCompany(name));
  }
}
```
