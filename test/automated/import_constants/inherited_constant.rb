require_relative '../automated_init'

context "Import Constants" do
  context "Inherited Constant" do
    inherited_namespace = Controls::Namespace.example
    source_namespace = Controls::Namespace::InheritNamespace.example(inherited_namespace)

    target_namespace = Controls::Namespace::Target.example

    ImportConstants.(source_namespace, target_namespace)

    context "Included Namespace's Constants" do
      some_constant = inherited_namespace::SomeConstant
      some_constant_imported = target_namespace.const_defined?(:SomeConstant) &&
        target_namespace::SomeConstant.equal?(some_constant)

      some_other_constant = inherited_namespace::SomeOtherConstant
      some_other_constant_imported = target_namespace.const_defined?(:SomeOtherConstant) &&
        target_namespace::SomeOtherConstant.equal?(some_other_constant)

      not_imported = !some_constant_imported && !some_other_constant_imported

      test "Not imported" do
        assert(not_imported)
      end
    end
  end
end
