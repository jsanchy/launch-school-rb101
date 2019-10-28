def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

# the return value of the following method invocation is "no"
bar(foo)
