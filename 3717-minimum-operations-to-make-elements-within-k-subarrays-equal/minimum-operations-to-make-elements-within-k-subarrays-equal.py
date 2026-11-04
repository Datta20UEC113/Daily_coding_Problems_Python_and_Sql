from typing import List
from heapq import heappush, heappop
from collections import defaultdict

class Solution:
    def minOperations(self, nums: List[int], x: int, k: int) -> int:
        n = len(nums)

        low, high = [], []
        deleted = defaultdict(int)
        low_sum = high_sum = 0
        low_size = high_size = 0

        def prune(heap, is_low):
            while heap:
                val = -heap[0] if is_low else heap[0]
                if deleted[val] == 0:
                    break
                deleted[val] -= 1
                heappop(heap)

        def balance():
            nonlocal low_sum, high_sum, low_size, high_size

            prune(low, True)
            prune(high, False)

            while low_size > high_size + 1:
                val = -heappop(low)
                low_sum -= val
                low_size -= 1
                heappush(high, val)
                high_sum += val
                high_size += 1
                prune(low, True)

            while low_size < high_size:
                val = heappop(high)
                high_sum -= val
                high_size -= 1
                heappush(low, -val)
                low_sum += val
                low_size += 1
                prune(high, False)

        def add(val):
            nonlocal low_sum, high_sum, low_size, high_size

            if not low or val <= -low[0]:
                heappush(low, -val)
                low_sum += val
                low_size += 1
            else:
                heappush(high, val)
                high_sum += val
                high_size += 1

            balance()

        def remove(val):
            nonlocal low_sum, high_sum, low_size, high_size

            prune(low, True)
            deleted[val] += 1

            if val <= -low[0]:
                low_sum -= val
                low_size -= 1
            else:
                high_sum -= val
                high_size -= 1

            prune(low, True)
            prune(high, False)
            balance()

        def get_cost():
            median = -low[0]
            return (
                median * low_size - low_sum
                + high_sum - median * high_size
            )

        for val in nums[:x]:
            add(val)

        costs = [get_cost()]

        for i in range(x, n):
            add(nums[i])
            remove(nums[i - x])
            costs.append(get_cost())

        prev = [0] * (n + 1)
        INF = float('inf')

        for j in range(1, k + 1):
            curr = [INF] * (n + 1)

            for i in range(x, n + 1):
                curr[i] = min(
                    curr[i - 1],
                    prev[i - x] + costs[i - x]
                )

            prev = curr

        return prev[n]