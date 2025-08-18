// #!MCVM cd ${mdir}/../build && ninja mcvm_emscripten_node && node\
// #!MCVM --experimental-wasm-exnref ../runner.js
#include <exception>
#include <iostream>
#include <meta>
#include <print>
#include <stdexcept>

struct xyz {
  int a;
  float b;
};
namespace mcvm_detail {
using namespace std;

consteval auto first_non_void(std::vector<std::meta::info> types)
  -> std::meta::info {
  using namespace std;
  for (meta::info t : types) {
    if (not is_void_type(t)) {
      return t;
    }
  }
  return ^^void;
}

template<auto... vals> struct template_arg_container {

  template<typename Function> constexpr auto for_each(Function&& fn) const {
    return (fn.template operator()<vals>(), ...);
  }
  template<auto Function> constexpr auto for_each() const {
    return (Function.template operator()<vals>(), ...);
  }
  template<typename Function> constexpr auto continuation(Function&& fn) const {
    return (fn.template operator()<vals>() && ...);
  }
  template<auto Function> constexpr auto continuation() const {
    return (Function.template operator()<vals>() && ...);
  }
  constexpr auto member_access(auto&& obj) const {
    return (obj.*....*&[:vals:]);
  }

  constexpr auto member_access(auto* obj) const { return member_access(*obj); }

  // template <typename Function> constexpr [:first_non_void(infos):]
  // operator->*(Function fnc) const {
  //     constexpr auto infos =
  //     meta::template_arguments_of(^^template_arg_container); constexpr auto
  //     ret = first_non_void(infos);
  // }

  template<typename Function> constexpr auto operator>>(Function fn) const {
    return for_each(fn);
  }

  template<typename Function> constexpr auto operator>>=(Function fn) const {
    return continuation(fn);
  }

  template<typename Function>
  constexpr void recursion_impl(Function fn) const {}

  template<typename Function, auto First, auto... Rest>
  constexpr void recursion_impl(Function fn) const {
    constexpr auto ppp = is_constexpr_invocable<fn, First>();

    if constexpr (is_constexpr_invocable<fn, First>()) {
      if constexpr (fn.template operator()<First>()) {
        recursion_impl<Function, Rest...>(fn);
      }
    } else {
      if constexpr (fn.template operator()<First>()) {
        recursion_impl<Function, Rest...>(fn);
      }
      // constexpr auto F = ^^Function;
      // LOG() << meta::display_string_of(F);
      // LOG() << what;
      // static_assert(what);
    }
    // else {
    //     if (fn.template operator()<First>()) {
    //         recursion_impl<Function, Rest...>(fn);
    //     }
    // }
  }

  // Public interface for continuation
  template<typename Function> constexpr void recursion(Function fn) const {
    recursion_impl<Function, vals...>(fn); // Start recursion
  }

  template<typename Function> constexpr void operator++(Function fn) const {
    recursion(fn);
  }
};

template<auto... vals>
template_arg_container<vals...> template_arg_container_inst = {};

template<typename... vals> struct t_template_arg_container {
  template<typename Function> constexpr void for_each(Function fn) const {

    // constexpr auto ret = decltype(fn.template operator()<vals>())

    (fn.template operator()<vals>(), ...);
  }

  template<typename Function> constexpr void continuation(Function fn) const {

    // constexpr auto ret = decltype(fn.template operator()<vals>())

    (fn.template operator()<vals>() && ...);
  }

  template<typename Function> constexpr void operator>>(Function fn) const {
    for_each(fn);
  }
};

template<typename... vals>
t_template_arg_container<vals...> t_template_arg_container_inst = {};
template<std::ranges::input_range R> consteval auto expand(R range) {
  using namespace std;
  vector<meta::info> reflected_values;
  for (auto r : range) {
    reflected_values.push_back(meta::reflect_constant(r));
  }
  return substitute(^^template_arg_container_inst,
                    reflected_values);
}

} // namespace mcvm_detail

template<std::ranges::input_range R> consteval auto operator~(R range) -> auto {
  return mcvm_detail::expand(range);
}
int main(int argc, char* argv[]) {
  //   std::print("Hello, World!");
  std::cout << "Hello, World!" << std::endl;
  [:~std::meta::members_of(
      ^^xyz, std::meta::access_context::unchecked()):] >> []<auto mem> {
    std::cout << display_string_of(mem) << std::endl;
  };

  throw std::runtime_error("HeXXXXXXXXX");
  //   try {
  //     throw std::runtime_error("Hello, World!");
  //   } catch (...) {
  //   }
  return 0;
}