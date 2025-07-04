require_relative '../../automated_init'

context "Import Constants" do
  context "Macro" do
    context "Optional Alias" do
      context "Constant Already Exists" do
        alias_name = :SomeAlias

        extant_constant = Module.new

        source_namespace = Controls::Namespace.example

        target_namespace = Controls::Namespace::Target.example
        target_namespace.include ImportConstants

        target_namespace.const_set(alias_name, extant_constant)

        test "Is an error" do
          assert_raises(ImportConstants::Error) do
            target_namespace.import_constants(source_namespace, as: alias_name)
          end
        end
      end
    end
  end
end
