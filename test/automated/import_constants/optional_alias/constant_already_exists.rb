require_relative '../../automated_init'

context "Import Constants" do
  context "Optional Alias" do
    context "Constant Already Exists" do
      alias_name = :SomeAlias

      source_namespace = Controls::Namespace.example

      target_name = Controls::Namespace::Target.name

      extant_constant = Module.new

      target_namespace = Controls::Namespace::Target.example(name: target_name)
      target_namespace.const_set(alias_name, extant_constant)

      test "Is an error" do
        assert_raises(ImportConstants::Error, "#{target_name}::#{alias_name} is already defined") do
          ImportConstants.(source_namespace, target_namespace, as: alias_name)
        end
      end
    end
  end
end
