require_relative '../automated_init'

context "Import Constants" do
  source_namespace = Controls::Namespace.example

  ImportConstants.(source_namespace)

  context "Inner Constants" do
    some_constant = source_namespace::SomeConstant
    some_constant_imported = Object.const_defined?(:SomeConstant) &&
      SomeConstant.equal?(some_constant)

    some_other_constant = source_namespace::SomeOtherConstant
    some_other_constant_imported = Object.const_defined?(:SomeOtherConstant) &&
      SomeOtherConstant.equal?(some_other_constant)

    imported = some_constant_imported && some_other_constant_imported

    test "Imported" do
      assert(imported)
    end

  ensure
    Object.class_exec do
      remove_const(:SomeConstant) if some_constant_imported
      remove_const(:SomeOtherConstant) if some_other_constant_imported
    end
  end
end
