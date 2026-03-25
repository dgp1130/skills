# TypeScript / JavaScript Style Guide

When generating code, follow the below guidance on my personal "voice" of TS / JS code. Prefer
following project-local and file-local conventions where they appear to disagree with this guidance.

## Format

* Use K&R indentation style with subsequent blocks on the same line as the
  trailing `}`.
* Use 2 spaces for indentation.
* Use 100 columns for line length limits.

```typescript
if (foo) {
  // ...
} else if (bar) {
  // ...
} else {
  // ...
}
```

* Use trailing commas.

```typescript
doSomething(
  {
    foo: 1,
  },
  [
    2,
  ],
  3,
);
```

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

## Semicolons

Always use semicolons to terminate statements.

```typescript
// BAD! Missing semicolon.
const x = 1

// GOOD! Semicolon present.
const x = 1;
```

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

// BAD! Don't use a new line without braces.
if (someLongConditional)
  return doSomethingEvenLongerAndMoreComplex(withComplicatedArgument());

// GOOD! Simple and clear.
if (x) return y();
for (const x of y) validate(x);
if (!isValid(x)) throw new Error('...');
if (!isValid(x)) continue;
```

## Switch Statements

* Prefer `switch` statements over `if` statements when appropriate.
* Always brace `case` statements.
* Always include a `break;`, `return;`, or `throw;` statement in each `case`,
  *never* fall through.

```typescript
switch (foo) {
  case bar: {
    // ...
    break;
  } default: {
    // ...
    break;
  }
}
```

## Iterators

Prefer `for` loops over `while` loops whenever possible. Avoid manual iteration in a `for` loop and
`for...in` whenever possible. If you need the index of a value, consider `Object.entries` or another
iterator. Consider the use of generators for more complex iteration patterns. Use
`Generator<T, void, void>` as the preferred return type.

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
fields and call `super`, nothing more. Do *not* use post-construction `initialize()` steps. If a
class requires non-trivial setup, consider using a factory function.

```typescript
// BAD! Doing side effects in a constructor.
class User {
  name: string;
  company: Company;

  constructor(name: string) {
    this.name = name;
    this.company = getCompany(name);
  }
}

// BAD! Using post-construction initialization.
class User {
  name: string;
  company!: Company;

  constructor(name: string) {
    this.name = name;
  }

  initialize(): void {
    this.company = getCompany(this.name);
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

## Prefer `??`

Prefer `??` over `||` for providing default values.

```typescript
// BAD!
const x = y || 0;

// GOOD!
const x = y ?? 0;
```

## Minimize Try Scope

Narrowly define `try-catch` statements to only catch unexpected errors for a particular line or
expression as much as possible.

```typescript
// BAD! Catching too much.
try {
  doSomething();

  doSomethingElse();

  doOneMoreThing();
} catch (e) {
  // ...
}

// GOOD! Catching only what we expect to throw.
try {
  doSomething();
} catch (e) {
  // ...
}
doSomethingElse();
doOneMoreThing();
```

## Comments

Include doc comments on exported or significant functions. Do not repeat type information.

```typescript
/**
 * A function that does something.
 *
 * @param arg - The argument to do something with.
 * @returns The result of doing something with the argument.
 */
export function doSomething(arg: string): string {
  // ...
}
```

## Minimize Work In Promises

Prefer `async` / `await` as much as possible and when `new Promise(...)` is needed, keep it's logic
limited to resolving / rejecting the `Promise` appropriately and move any other work into an `async`
/ `await` layer.

```typescript

// BAD! Doing work inside of a Promise constructor.
function doSomething(arg: string): Promise<number> {
  return new Promise<number>((resolve) => {
    setTimeout(() => {
      const result = doComplicatedThing(arg);
      resolve(result);
    });
  });
}

// GOOD! Moving work out of the `Promise` constructor.
async function doSomething(arg: string): Promise<number> {
  await new Promise<void>((resolve) => {
    setTimeout(() => {
      resolve();
    });
  });

  return doComplicatedThing(arg);
}
```

## References

When referring to TS/JS symbols in comments, commit messages, or user responses, use
`Foo.prototype.bar` syntax to refer to methods / properties. Don't use `()` for functions unless
you are specifically referring to an invoked situation. You can abbreviate to just the method /
property name (`bar`) in repeated situations or when the class name is obvious.
