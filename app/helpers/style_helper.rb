module StyleHelper
  def button_classes
    class_variants(
      base: "inline-flex items-center rounded-sm text-sm font-semibold border focus-visible:outline-2 focus-visible:outline-offset-2 bg-black focus-visible:outline-black",
      variants: {
        variant: {
          base: "bg-white text-black hover:bg-black hover:border-white hover:text-white",
          invert: "bg-black text-white hover:bg-white hover:border-black hover:text-black"
        },
        size: {
          sm: "px-2.5 py-1.5 text-xs",
          md: "px-3 py-2 text-sm",
          lg: "px-4 py-2 text-sm",
          xl: "px-4 py-2 text-base"
        },
        full: "w-full"
      },
      defaults: {
        variant: :base,
        size: :md,
        full: false
      }
    )
  end

  def input_classes
    class_variants(
      base: "block rounded-sm bg-white font-medium placeholder:font-normal text-black outline-1 -outline-offset-1 outline-black placeholder:text-black/60 focus:outline-2 focus:-outline-offset-2 focus:outline-black",
      variants: {
        size: {
          sm: "py-1.5 px-2  text-xs",
          md: "py-2 px-3 text-sm",
          lg: "py-3 px-4 text-base",
          xl: "py-4 px-5 text-xl"
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
