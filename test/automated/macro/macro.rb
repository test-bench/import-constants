require_relative '../automated_init'

context "Import Constants" do
  context "Macro" do
    source_namespace = Controls::Namespace.example

    target_namespace = Controls::Namespace::Target.example
    target_namespace.include ImportConstants

    target_namespace.import_constants source_namespace

    context "Inner Constants" do
      some_constant = source_namespace::SomeConstant
      some_constant_imported = target_namespace.const_defined?(:SomeConstant) &&
        target_namespace::SomeConstant.equal?(some_constant)

      some_other_constant = source_namespace::SomeOtherConstant
      some_other_constant_imported = target_namespace.const_defined?(:SomeOtherConstant) &&
        target_namespace::SomeOtherConstant.equal?(some_other_constant)

      imported = some_constant_imported && some_other_constant_imported

      test "Imported" do
        assert(imported)
      end
    end
  end
end
