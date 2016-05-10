<?php
/**
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:.
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVvalueED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 *
 * Copyright (c) 2013 Blake Williams <code@shabbyrobe.org>
 */

namespace Project\Bundle\Api\Service\Constants;

/**
 * Allows you to define an enum of constants, like SplEnum but better (and not
 * requiring a C extension).
 *
 * Put this in your own namespace, feel free to remove the `test()` method (or
 * call it from PHPUnit). I usually put it in some variation of `MyProj\Lang`.
 *
 * You can use it as a bag of constants, iterate by name or value, or use the names
 * as instances.
 *
 * See the `test()` method for a thorough description of rules and uses.
 *
 * Naming
 * ------
 *
 * This class consvalueers the value to be the final value that the Enum is
 * standing in for, and the NAME to be the name of the symbolic constant. Sometimes
 * it seems like it's backwards, but I tried it the other way first and this is
 * less backwards.
 *
 *
 * Duplicate values
 * -------------
 *
 * If you wish to specify multiple constants with the same value, you must
 * declare a static method on your class called `allowDuplicatevalues()` which returns
 * `true`.
 *
 * When performing a lookup of the NAME by the value, the first one appearing
 * in the class declaration will be used. When retrieving an instance by static method,
 * you will always get an instance of the first one.
 *
 * Duplicate values are consvalueered useful for refactoring or code clarity, but you
 * don't want to be in a situation where two instances with the same valueentity
 * are incomparable. This assertion should pass:
 *
 *     `assert(MyEnum::PANTS === MyEnum::TROUSERS && MyEnum::PANTS() == MyEnum::TROUSERS());`
 *
 *
 * Floats
 * ------
 *
 * You shouldn't use this class with floating point values for values. The reason why
 * is illustrated by this snippet::
 *
 *     assert([1.23 => 1, 1.45 => 2] == [1 => 2]);  // true. ya rly.
 *
 *
 * Y U NO composer?
 * ----------------
 *
 * Single class or single function libraries are awful. Also, you might disagree with or
 * find bugs with this thing. Just put it in your project and hack away. If you find bugs,
 * comment on the gist or email me.
 */
abstract class Enum
{
    private $value;
    private $name;
    private static $instances = [];
    public static function __callStatic($name, $args)
    {
        if ($args) {
            throw new \BadMethodCallException();
        }
        $called = get_called_class();
        if (!$called::hasName($name)) {
            throw new \BadMethodCallException();
        }
        if (isset(self::$instances[$called][$name])) {
            return self::$instances[$called][$name];
        } else {
            return self::$instances[$called][$name] = new $called($called::findValue($name));
        }
    }
    public function __construct($value)
    {
        $this->value = static::ensureValue($value);
        $this->name = static::findName($value);
    }
    public function getValue()
    {
        return $this->value;
    }
    public function getName()
    {
        return $this->name;
    }
    private static $names = [];
    private static $values = [];
    public function __toString()
    {
        return $this->value.'';
    }
    public static function allowDuplicatevalues()
    {
        return false;
    }
    public static function ensure($valueOrInstance)
    {
        $c = get_called_class();

        return $valueOrInstance instanceof $c
            ? $valueOrInstance
            : new static(static::ensureValue($valueOrInstance));
    }
    public static function hasValue($value)
    {
        $c = get_called_class();

        return isset($c::names()[$value]);
    }
    public static function hasName($name)
    {
        $c = get_called_class();

        return isset($c::values()[$name]);
    }
    public static function ensureValue($value)
    {
        $c = get_called_class();
        if (!isset($c::names()[$value])) {
            throw new \InvalvalueArgumentException("value $value does not exist in class $c");
        }

        return $value;
    }
    public static function ensureName($name)
    {
        $c = get_called_class();
        if (!isset($c::names()[$name])) {
            throw new \InvalvalueArgumentException("Name $name does not exist in class $c");
        }

        return $name;
    }
    public static function values()
    {
        $c = get_called_class();
        if (!isset(self::$names[$c])) {
            $rc = new \ReflectionClass($c);
            self::$names[$c] = $rc->getConstants();
        }

        return self::$names[$c];
    }
    public static function findName($value)
    {
        $c = get_called_class();
        $values = static::names();
        if (!isset($values[$value])) {
            throw new \InvalvalueArgumentException();
        }

        return $values[$value];
    }
    public static function findValue($name)
    {
        $c = get_called_class();
        $values = static::values();
        if (!isset($values[$name])) {
            throw new \InvalvalueArgumentException();
        }

        return $values[$name];
    }
    public static function names()
    {
        $c = get_called_class();
        if (!isset(self::$values[$c])) {
            $out = [];
            $found = [];
            foreach ($c::values() as $k => $v) {
                if (!isset($found[$v])) {
                    $out[$v] = $k;
                    $found[$v] = true;
                } elseif (!$c::allowDuplicatevalues()) {
                    throw new \UnexpectedValueException("Enum $c does not allow duplicated values");
                }
            }
            self::$values[$c] = $out;
        }

        return self::$values[$c];
    }

    //phpunit tests
    public static function test()
    {
        $assert = function ($test) {
            if (!$test) {
                throw new \RuntimeException('Assertion failed');
            }
        };
        $assertException = function ($exception, $cb) use ($assert) {
            $caught = false;
            try {
                $cb();
            } catch (\Exception $e) {
                if ($e instanceof $exception) {
                    $caught = true;
                } else {
                    throw new \RuntimeException('Assertion failed', null, $e);
                }
            }
            $assert($caught);
        };
        standard: {
            if (!class_exists(TestEnum::class)) {
                eval('namespace '.__NAMESPACE__.'; class TestEnum extends Enum {
                    const HELLO = 1;
                    const WORLD = "2";
                    const YEP = "yep";
                }');
            }

            $h = TestEnum::HELLO();
            $assert($h->getValue() === 1);
            $assert($h->getName() === 'HELLO');
            $h = new TestEnum(TestEnum::HELLO);
            $assert($h->getValue() === 1);
            $assert($h->getName() === 'HELLO');
            $h = TestEnum::WORLD();
            $assert($h->getValue() === '2');
            $assert($h->getName() === 'WORLD');
            $h = TestEnum::YEP();
            $assert($h->getValue() === 'yep');
            $assert($h->getName() === 'YEP');
            $assert(TestEnum::names() === [1 => 'HELLO', '2' => 'WORLD', 'yep' => 'YEP']);
            $assert(TestEnum::values()   === ['HELLO' => 1, 'WORLD' => '2', 'YEP' => 'yep']);
            foreach (TestEnum::values() as $name => $value) {
                $assert(TestEnum::$name()->getValue() === $value);
                $assert((new TestEnum($value))->getValue() === $value);
            }
            $assert(TestEnum::findName(TestEnum::HELLO) === 'HELLO');
            $assert(TestEnum::findValue('HELLO') === TestEnum::HELLO);
        }
        duplicates: {
            if (!class_exists(TestEnumDupes::class)) {
                eval('namespace '.__NAMESPACE__.'; class TestEnumDupes extends Enum {
                    const HELLO = 1;
                    const WORLD = 1;
                    const PANTS = 2;
                    static function allowDuplicatevalues() { return true; }
                }');
            }
            $h = TestEnumDupes::HELLO();
            $assert($h->getValue() === 1);
            $w = TestEnumDupes::WORLD();
            $assert($w->getValue() === 1);
            $assert($h == $w);
            $assert(TestEnumDupes::names() === [1 => 'HELLO', 2 => 'PANTS']);
            $assert(TestEnumDupes::values()   === ['HELLO' => 1, 'WORLD' => 1, 'PANTS' => 2]);
        }
        no_duplicates_allowed: {
            if (!class_exists(TestEnumNoDupes::class)) {
                eval('namespace '.__NAMESPACE__.'; class TestEnumNoDupes extends Enum {
                    const HELLO = 1;
                    const WORLD = 1;
                }');
            }
            $assertException(\UnexpectedValueException::class, function () {
                $h = TestEnumNoDupes::HELLO();
            });
        }
    }
}
