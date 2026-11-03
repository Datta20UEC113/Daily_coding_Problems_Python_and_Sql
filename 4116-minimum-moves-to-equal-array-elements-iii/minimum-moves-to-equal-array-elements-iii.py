class Solution:
    def minMoves(self, nums: List[int]) -> int:
        m = max(nums)
        s = 0
        for i in nums:
            s += abs(i - m)
        return s