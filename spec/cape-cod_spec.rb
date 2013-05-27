# encoding: utf-8

require 'spec_helper'

describe CapeCod do
  it('has a version') { expect(CapeCod::VERSION).to be_a String }

  context 'disabled' do
    before(:all) { CapeCod.enabled = false }

    context 'using singleton methods' do
      it('does nothing') { expect(CapeCod.bold).to be_empty }
    end

    context 'using instance methods' do
      before do
        class StringWithCapeCodIncluded < String; include CapeCod end
      end

      let(:target) { StringWithCapeCodIncluded.new('some text') }

      it 'does nothing' do
        expect(target.red.bold.fx(:italic).bg(:cyan)).to eql target
      end
    end
  end

  context 'enabled' do
    before(:all) { CapeCod.enabled = true }

    let(:target) { 'some text' }

    context 'using singleton methods' do
      let(:reset)       { %(\e[0m)  }
      let(:bold)        { %(\e[1m)  }
      let(:italic)      { %(\e[3m)  }
      let(:red)         { %(\e[31m) }
      let(:on_red)      { %(\e[41m) }
      let(:rgb_red_fg)  { %(\e[38;5;180m) }
      let(:rgb_red_bg)  { %(\e[48;5;180m) }

      it { should respond_to :fx }
      it { should respond_to :fg }
      it { should respond_to :bg }

      context 'no params given' do
        it 'returns the effect escape sequence' do
          expect(CapeCod.bold).to eq(bold)
        end

        it 'returns the foreground color escape sequence' do
          expect(CapeCod.red).to eq(red)
        end

        it 'returns the background color escape sequence' do
          expect(CapeCod.on_red).to eq(on_red)
        end
      end

      context 'object param given' do
        let(:target) { ['foo', 10, :bar] }

        it 'returns a new object' do
          expect(CapeCod.bold(target).object_id).to_not eql(target.object_id)
        end

        context 'using direct method' do
          it "escapes the object with the effect's sequence" do
            expect(CapeCod.bold(target)).to eq("#{bold}#{target}#{reset}")
          end

          it "escapes the object with the foreground color's sequence" do
            expect(CapeCod.red(target)).to eq("#{red}#{target}#{reset}")
          end

          it "escapes the object with the background color's sequence" do
            expect(CapeCod.on_red(target)).to eq("#{on_red}#{target}#{reset}")
          end
        end

        context 'passing a symbol with color/effect name' do
          it "escapes the object with the effect's sequence" do
            expect(CapeCod.fx(:bold, target)).to eq("#{bold}#{target}#{reset}")
          end

          context 'colorization' do
            context 'using color names' do
              it "escapes the object with the foreground color's sequence" do
                expect(CapeCod.fg(:red, target)).to(
                  eq("#{red}#{target}#{reset}"))
              end

              it "escapes the object with the background color's sequence" do
                expect(CapeCod.bg(:red, target)).to(
                  eq("#{on_red}#{target}#{reset}"))
              end
            end

            context 'using RGB' do
              context 'passing three integers' do
                it "escapes the object with the foreground color's sequence" do
                  expect(CapeCod.fg(255, 0, 0, target)).to(
                    eq("#{rgb_red_fg}#{target}#{reset}"))
                end

                it "escapes the object with the background color's sequence" do
                  expect(CapeCod.bg(255, 0, 0, target)).to(
                    eq("#{rgb_red_bg}#{target}#{reset}"))
                end
              end

              context 'passing a single integer (hex representation)' do
                it "escapes the object with the foreground color's sequence" do
                  expect(CapeCod.fg(0xff0000, target)).to(
                    eq("#{rgb_red_fg}#{target}#{reset}"))
                end

                it "escapes the object with the background color's sequence" do
                  expect(CapeCod.bg(0xff0000, target)).to(
                    eq("#{rgb_red_bg}#{target}#{reset}"))
                end
              end
            end
          end
        end

        it 'works properly with multiple calls passing the same object' do
          expect(
            CapeCod.red(CapeCod.italic(CapeCod.bold(CapeCod.on_red(target))))
          ).to eql(
            ''.tap do |s|
              s << "#{red}#{italic}#{bold}#{on_red}"
              s << "#{target}"
              s << "#{reset}#{reset}#{reset}#{reset}"
            end
          )
        end
      end
    end

    context 'using instance methods' do
      before :all do
        class String
          include CapeCod
        end
      end

      it('provides the "fx" alias') { String.public_method_defined? :fx }
      it('provides the "fg" alias') { String.public_method_defined? :fg }
      it('provides the "bg" alias') { String.public_method_defined? :bg }

      context 'using direct methods' do
        it 'returns a new string' do
          expect(target.red.object_id).to_not eql(target.object_id)
        end

        it 'behaves the same way as singleton methods for foreground colors' do
          expect(target.red).to eql(CapeCod.red(target))
        end

        it 'behaves the same way as singleton methods for background colors' do
          expect(target.on_red).to eql(CapeCod.on_red(target))
        end

        it 'behaves the same way as singleton methods for effects' do
          expect(target.bold).to eql(CapeCod.bold(target))
        end

        it 'behaves the same way as singleton methods for chained calls' do
          expect(
            target.on_red.bold.italic.red
          ).to eql(
            CapeCod.red(CapeCod.italic(CapeCod.bold(CapeCod.on_red(target))))
          )
        end
      end

      context 'passing a symbol with color/effect name' do
        it 'returns a new string' do
          expect(target.red.object_id).to_not eql(target.object_id)
        end

        it 'behaves the same way as singleton methods for foreground colors' do
          expect(target.foreground(:red)).to eql(CapeCod.red(target))
        end

        it 'behaves the same way as singleton methods for background colors' do
          expect(target.background(:red)).to eql(CapeCod.on_red(target))
        end

        it 'behaves the same way as singleton methods for effects' do
          expect(target.effect(:bold)).to eql(CapeCod.bold(target))
        end

        it 'behaves the same way as singleton methods for chained calls' do
          expect(
            target.bg(:red).fx(:bold).fx(:italic).fg(:red)
          ).to eql(
            CapeCod.red(CapeCod.italic(CapeCod.bold(CapeCod.on_red(target))))
          )
        end
      end
    end
  end
end
