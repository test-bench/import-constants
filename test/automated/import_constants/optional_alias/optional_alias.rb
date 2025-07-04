require_relative '../../automated_init'

context "Import Constants" do
  context "Optional Alias" do
    alias_name = :SomeAlias

    source_namespace = Controls::Namespace.example

    target_namespace = Controls::Namespace::Target.example

    ImportConstants.(source_namespace, target_namespace, as: alias_name)

    context! "Alias is defined" do
      defined = target_namespace.const_defined?(alias_name)

      test do
        assert(defined)
      end
    end

    context "Inner Constants" do
      target_alias = target_namespace.const_get(alias_name)

      some_constant = source_namespace::SomeConstant
      some_constant_imported = target_alias.const_defined?(:SomeConstant) &&
        target_alias::SomeConstant.equal?(some_constant)

      some_other_constant = source_namespace::SomeOtherConstant
      some_other_constant_imported = target_alias.const_defined?(:SomeOtherConstant) &&
        target_alias::SomeOtherConstant.equal?(some_other_constant)

      imported = some_constant_imported && some_other_constant_imported

      test "Imported into alias" do
        assert(imported)
      end
    end
  end
end
