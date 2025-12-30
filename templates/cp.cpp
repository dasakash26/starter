/*

      |\      _,,,---,,_
ZZZzz /,`.-'`'    -.  ;-;;,_
     |,4-  ) )-,_. ,\ (  `'-'
    '---''(_/--'  `-'\_)

 */
#include <bits/stdc++.h>

using namespace std;

using ll = long long;
using ull = unsigned long long;
using ld = long double;

using pll = pair<ll, ll>;
using pld = pair<ll, ld>;
using pdd = pair<ld, ld>;

using vll = vector<ll>;
using vul = vector<ull>;
using vld = vector<ld>;
using vb = vector<bool>;
using vch = vector<char>;
using vs = vector<string>;

using vvll = vector<vll>;
using vvul = vector<vul>;
using vvld = vector<vld>;
using vvb = vector<vb>;
using vvch = vector<vch>;
using vvs = vector<vs>;

using vpll = vector<pll>;
using vpld = vector<pld>;
using vpdd = vector<pdd>;

using qll = queue<ll>;
using sll = stack<ll>;
using dll = deque<ll>;

using qpll = queue<pll>;
using spll = stack<pll>;
using dpll = deque<pll>;

using min_pqll = priority_queue<ll, vector<ll>, greater<ll>>;
using max_pqll = priority_queue<ll>;

#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()
#define pb push_back
#define ff first
#define ss second
#define rep(i, l, r) for (int i = (l); i < (r); ++i)
#define rev(i, r, l) for (int i = (r); i >= (l); --i)
#define sz(x) int((x).size())

#define read(a)                                                                \
  for (auto &x : (a))                                                          \
  cin >> x
#define readm(mat)                                                             \
  for (auto &row : (mat))                                                      \
    for (auto &x : row)                                                        \
  cin >> x
#define p(x) cout << (x) << '\n';
#define ps(x) cout << (x) << ' ';
#define YES cout << "YES\n"
#define NO cout << "NO\n"
#define yn(x) ((x) ? YES : NO)
#define pln cout << "\n";
#define ln "\n"

#ifndef ONLINE_JUDGE
#include <type_traits>

template <typename T, typename = void> struct is_iterable : false_type {};
template <typename T>
struct is_iterable<
    T, void_t<decltype(begin(declval<T &>())), decltype(end(declval<T &>()))>>
    : true_type {};

template <typename T> void _print(const T &x);
template <typename T, typename V> void _print(const pair<T, V> &p);

void _print(const char *s) { cerr << '"' << s << '"'; }
void _print(const string &s) { cerr << '"' << s << '"'; }
void _print(char c) { cerr << '\'' << c << '\''; }
void _print(bool b) { cerr << (b ? "true" : "false"); }

template <typename T, typename V> void _print(const pair<T, V> &p) {
  cerr << '{';
  _print(p.first);
  cerr << ", ";
  _print(p.second);
  cerr << '}';
}

template <typename T> void _print(const T &x) {
  if constexpr (is_iterable<T>::value) {
    int f = 0;
    cerr << '{';
    for (const auto &i : x) {
      cerr << (f++ ? ", " : "");
      _print(i);
    }
    cerr << '}';
  } else {
    cerr << x;
  }
}

void _dbg_out() { cerr << "]\n"; }
template <typename T, typename... V> void _dbg_out(T t, V... v) {
  _print(t);
  if (sizeof...(v))
    cerr << ", ";
  _dbg_out(v...);
}

#define dbg(...) cerr << #__VA_ARGS__ << " = [", _dbg_out(__VA_ARGS__)
#else
#define dbg(...) (void)0
#endif

constexpr int MOD = 1'000'000'007;
constexpr int N = 200'005;

static mt19937_64 rng(chrono::steady_clock::now().time_since_epoch().count());
inline ll rnd(ll L, ll R) { return uniform_int_distribution<ll>(L, R)(rng); }

struct custom_hash {
  static uint64_t splitmix64(uint64_t x) {
    x += 0x9e3779b97f4a7c15;
    x = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9;
    x = (x ^ (x >> 27)) * 0x94d049bb133111eb;
    return x ^ (x >> 31);
  }
  size_t operator()(uint64_t x) const {
    static const uint64_t FIXED =
        chrono::steady_clock::now().time_since_epoch().count();
    return splitmix64(x + FIXED);
  }
  size_t operator()(const pair<ll, ll> &p) const {
    return splitmix64(p.first ^ (p.second << 32));
  }
};

template <typename K, typename V> using umap = unordered_map<K, V, custom_hash>;
template <typename K> using uset = unordered_set<K, custom_hash>;
template <typename K, typename V>
using ummap = unordered_multimap<K, V, custom_hash>;
template <typename K> using umset = unordered_multiset<K, custom_hash>;

template <typename T> bool chmin(T &a, T b) {
  return (b < a) ? (a = b, true) : false;
}
template <typename T> bool chmax(T &a, T b) {
  return (b > a) ? (a = b, true) : false;
}

inline int addMod(int a, int b) {
  int s = a + b;
  if (s >= MOD)
    s -= MOD;
  return s;
}

inline int mulMod(ll a, ll b) { return int((a * b) % MOD); }

inline int powMod(int base, ll exp = MOD - 2) {
  ll res = 1, x = base;
  while (exp) {
    if (exp & 1)
      res = res * x % MOD;
    x = x * x % MOD;
    exp >>= 1;
  }
  return int(res);
}

// ┌─────────────────────────[ solve() ]─────────────────────────┐
//
//
//

void solve() {
  // --CODE--
  ll n;
  cin >> n;
}

//
//
//
// └──────────────────────────[ end ]─────────────────────────────┘

int main() {
  ios::sync_with_stdio(false);
  cin.tie(nullptr);

  int T = 1;
  cin >> T;
  for (int tc = 1; tc <= T; ++tc) {
    dbg(tc);
    solve();
  }
  return 0;
}
