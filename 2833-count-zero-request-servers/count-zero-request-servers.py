
class Solution:
    def countServers(self, n: int, logs: list[list[int]],
                     x: int, queries: list[int]) -> list[int]:

        logs.sort(key=lambda log: log[1])

        sorted_queries = sorted(enumerate(queries),
                                key=lambda q: q[1])

        freq = {}
        left = 0
        right = 0
        active = 0
        ans = [0] * len(queries)

        for idx, q in sorted_queries:
            while right < len(logs) and logs[right][1] <= q:
                server = logs[right][0]

                if freq.get(server, 0) == 0:
                    active += 1

                freq[server] = freq.get(server, 0) + 1
                right += 1

            while left < right and logs[left][1] < q - x:
                server = logs[left][0]
                freq[server] -= 1

                if freq[server] == 0:
                    active -= 1

                left += 1

            ans[idx] = n - active

        return ans
