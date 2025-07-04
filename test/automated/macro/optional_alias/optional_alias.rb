require_relative '../../automated_init'

context "Import Constants" do
  context "Macro" do
    context "Optional Alias" do
      alias_name = :SomeAlias

      source_namespace = Controls::Namespace.example

      target_namespace = Controls::Namespace::Target.example
      target_namespace.include ImportConstants

      target_namespace.import_constants(source_namespace, as: alias_name)

      context "Alias is defined" do
        defined = target_namespace.const_defined?(alias_name)

        test do
          assert(defined)
        end
      end
    end
  end
end
