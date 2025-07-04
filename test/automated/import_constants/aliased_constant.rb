require_relative '../automated_init'

context "Import Constants" do
  context "Aliased Constant" do
    aliased_namespace = Controls::Namespace.example
    source_namespace = Controls::Namespace::AliasNamespace.example(aliased_namespace)

    target_namespace = Controls::Namespace::Target.example

    ImportConstants.(source_namespace, target_namespace)

    context "Aliased Namespace's Constants" do
      some_constant = aliased_namespace::SomeConstant
      some_constant_imported = target_namespace.const_defined?(:SomeConstant) &&
        target_namespace::SomeConstant.equal?(some_constant)

      some_other_constant = aliased_namespace::SomeOtherConstant
      some_other_constant_imported = target_namespace.const_defined?(:SomeOtherConstant) &&
        target_namespace::SomeOtherConstant.equal?(some_other_constant)

      imported = some_constant_imported && some_other_constant_imported

      test "Imported" do
        assert(imported)
      end
    end
  end
end
