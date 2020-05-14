require "./spec_helper"

describe Hash do
  describe "merges hashes of the same type" do
    describe "basic hashes" do
      it "merges values for non-overlapping keys" do
        a = {
          "a" => 1,
        }

        b = {
          "b" => 2,
        }

        result = {
          "a" => 1,
          "b" => 2,
        }

        a.deep_merge(b).should eq(result)
        a.deep_merge!(b).should eq(result)
      end

      it "overwrites values for overlapping keys" do
        a = {
          "a" => 1,
        }

        b = {
          "a" => 2,
        }

        result = {
          "a" => 2,
        }

        a.deep_merge(b).should eq(result)
        a.deep_merge!(b).should eq(result)
      end
    end

    describe "nested hashes" do
      it "overwrites values for overlapping keys" do
        a = {
          "a" => {
            "b" => 2,
          },
        }

        b = {
          "a" => {
            "b" => 3,
          },
        }

        result = {
          "a" => {
            "b" => 3,
          },
        }

        a.deep_merge(b).should eq(result)
        a.deep_merge!(b).should eq(result)
      end

      it "overwrites values overlapping keys without children when nested and preserves siblings" do
        a = {
          "a" => {
            "b" => 2,
            "c" => 2,
          },
        }

        b = {
          "a" => {
            "c" => 3,
          },
          "d" => 4,
        }

        result = {
          "a" => {
            "b" => 2,
            "c" => 3,
          },
          "d" => 4,
        }

        a.deep_merge(b).should eq(result)
      end
    end

    it "nested hashes" do
      a = {
        "a" => {
          "b" => 2,
        },
      }

      b = {
        "a" => {
          "c" => 3,
        },
        "d" => 4,
      }

      result = {
        "a" => {
          "b" => 2,
          "c" => 3,
        },
        "d" => 4,
      }
      a.deep_merge(b).should eq(result)
    end
  end

  describe "merges hashes of the different types" do
    it "left is a nested hash" do
      a = {
        "a" => {
          "b" => 2,
        },
      }

      b = {
        "c" => 3,
      }

      result = {
        "a" => {
          "b" => 2,
        },
        "c" => 3,
      }

      a.deep_merge(b).should eq(result)
    end

    it "right is a nested hash" do
      a = {
        "c" => 3,
      }

      b = {
        "a" => {
          "b" => 2,
        },
      }

      result = {
        "a" => {
          "b" => 2,
        },
        "c" => 3,
      }

      a.deep_merge(b).should eq(result)
    end
  end

  it "overwrites values for overlapping keys when right is a nested hash" do
    a = {
      "a" => 1,
    }

    b = {
      "a" => {
        "b" => 2,
      },
    }

    result = {
      "a" => {
        "b" => 2,
      },
    }

    a.deep_merge(b).should eq(result)
  end

  it "bang merges nested hashes of the same type" do
    a = {
      "a" => {
        "b" => 2,
      },
    }

    b = {
      "a" => {
        "c" => 3,
      },
    }

    result = {
      "a" => {
        "b" => 2,
        "c" => 3,
      },
    }

    a.deep_merge!(b).should eq(result)
  end

  it "bang overwrites keys with same name if not a hash and of the same type" do
    a = {
      "a" => 1,
    }

    b = {
      "a" => 2,
    }

    result = {
      "a" => 2,
    }

    a.deep_merge!(b).should eq(result)
  end

  it "bang overwrites keys with same name without children when nested and of the same type" do
    a = {
      "a" => {
        "b" => 2,
      },
    }

    b = {
      "a" => {
        "b" => 3,
      },
    }

    result = {
      "a" => {
        "b" => 3,
      },
    }

    a.deep_merge!(b).should eq(result)
  end

  it "bang overwrites keys with same name without children when nested and of the same type, but preserves siblings" do
    a = {
      "a" => {
        "b" => 2,
        "c" => 2,
      },
      "d" => 4,
    }

    b = {
      "a" => {
        "c" => 3,
      },
      "e" => 5,
    }

    result = {
      "a" => {
        "b" => 2,
        "c" => 3,
      },
      "d" => 4,
      "e" => 5,
    }

    a.deep_merge!(b).should eq(result)
  end
end
