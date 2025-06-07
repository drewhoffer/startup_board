module StyleHelper
  def button_classes
    class_variants(
      base: "inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-black border hover:bg-black hover:border-white hover:text-white focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-black",
      variants: {
        size: {
          sm: "px-2.5 py-1.5 text-xs",
          md: "px-3 py-2 text-sm",
          lg: "px-4 py-2 text-sm",
          xl: "px-4 py-2 text-base",
          full: "w-full"
        }
      },
      defaults: {
        size: :md,
        full: false
      }
    )
  end

  def input_classes
    class_variants(
      base: "block rounded-md bg-white font-medium placeholder:font-normal text-black outline-1 -outline-offset-1 outline-black placeholder:text-black focus:outline-2 focus:-outline-offset-2 focus:outline-black",
      variants: {
        size: {
          sm: "py-1.5 pl-8 pr-2 text-xs",
          md: "py-2 pl-10 pr-3 text-sm",
          lg: "py-3 pl-12 pr-4 text-base",
          xl: "py-4 pl-14 pr-5 text-xl"
        },
        full: "w-full"
      },
      defaults: {
        size: :md,
        full: true
      }
    )
  end
end
