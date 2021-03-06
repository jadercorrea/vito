require "spec_helper"

describe "Git recipe" do
  Vito::Tests::VagrantTestBox.boxes(:ubuntu10, :ubuntu12).each do |box|
    it "tests on #{box.name}" do
      setup_vagrant(box)

      assert_installation(box, "git --version").should be_false

      Vito::DslFile.new.run do
        server do
          connection :ssh, command: "ssh -i ~/.vagrant.d/insecure_private_key vagrant@localhost -p#{box.ssh_port}", verbose: true
          install :git
        end
      end

      assert_installation(box, "git --version").should be_true
    end
  end
end
