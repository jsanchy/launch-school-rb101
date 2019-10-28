munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

mess_with_demographics(munsters)

# the family's data got ransacked. The arugment passed to the method is
# a pointer to the munsters hash, not a copy. Although the values method
# creates a new array, it's values are again pointers the same hash values
# of the munsters hash. So, when the element assignment occurs, it
# makes those changes to those hashes, which are reflected in the outer
# munsters hash.
