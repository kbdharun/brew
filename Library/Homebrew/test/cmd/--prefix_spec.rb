# typed: false
# frozen_string_literal: true

require "cmd/shared_examples/args_parse"

describe "Homebrew.__prefix_args" do
  it_behaves_like "parseable arguments"
end

describe "brew --prefix", :integration_test do
  it "prints a given Formula's prefix" do
    expect { brew "--prefix", testball }
      .to output(%r{#{HOMEBREW_CELLAR}/testball}o).to_stdout
      .and not_to_output.to_stderr
      .and be_a_success
  end

  it "errors if the given Formula doesn't exist" do
    expect { brew "--prefix", "--installed", "nonexistent" }
      .to output(/No available formula/).to_stderr
      .and not_to_output.to_stdout
      .and be_a_failure
  end

  it "prints a warning with `--installed` if the given Formula is not installed" do
    expect { brew "--prefix", "--installed", testball }
      .to not_to_output.to_stdout
      .and output(/testball/).to_stderr
      .and be_a_failure
  end
end
